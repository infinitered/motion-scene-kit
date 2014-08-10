class SCNUtils

  def run_transactions(blocks, params = {})
    if blocks
      @blocks = blocks
      @current_block = 0
    else
      @current_block += 1
      if @current_block == @blocks.length
        return true
      end
    end

    opts = {
      animations: @blocks[@current_block],
      after: ->{self.run_transactions(nil, params)}
    }.merge(params)

    SCNUtils.transaction(opts)
  end

  class << self
    def transaction(params = {}, &block)
      duration = params[:duration] || 0.4

      after = params[:after]
      animations = params[:animations] || block

      SCNTransaction.begin
      SCNTransaction.completionBlock = after if after
      SCNTransaction.setAnimationDuration(duration)
      SCNTransaction.setAnimationTimingFunction(TimingFunction.get(params[:timing_function]))

      animations.call

      SCNTransaction.commit
    end

    def transactions(blocks, params = {})
      SCNUtils.new.run_transactions(blocks, params)
    end

    # @example
    # SCNUtils.add_animation(some_node, :transform, to: CATransform3D.rotate(Math::PI), reverses: false, duration: 1.0, TimingFunction.get: :linear)
    def add_animation(node, animation_key, params)
      attribute = params[:attribute] || params[:key_path] || :transform
      duration = params[:duration] || 0.3

      # I want varous names for this, because it's boolean, I'm doing it weird
      auto_reverses = params[:auto_reverses]
      auto_reverses = params[:autoreverses] if auto_reverses.nil?
      auto_reverses = params[:reverses] if auto_reverses.nil?
      auto_reverses = true if auto_reverses.nil?

      repeat_count = params[:repeat_count] || Float::INFINITY

      from = params[:from] || params[:from_value]
      to = params[:to] || params[:to_value]

      from = from.to_ns_value if from.is_a?(CATransform3D)
      to = to.to_ns_value if to.is_a?(CATransform3D)

      animation = CABasicAnimation.animationWithKeyPath(attribute.to_s)
      animation.fromValue = from if from
      animation.toValue = to if to
      animation.duration = duration
      animation.autoreverses = auto_reverses
      animation.repeatCount = repeat_count
      animation.timingFunction = TimingFunction.get(params[:timing_function])
      node.addAnimation(animation, forKey: animation_key)
      node
    end

    # SCNUtils.read_dae('airplane', object_name: 'airplane')
    def read_dae(file_name, params = {})
      url = NSBundle.mainBundle.URLForResource(file_name, withExtension: 'dae')
      scene = SCNScene.sceneWithURL(url, options: nil, error: Pointer.new(:object))

      if object_name = params[:object_name]
        scene.rootNode.childNodeWithName(object_name, recursively: true)
      else
        scene
      end
    end

    # SCNUtils.write_dae_from_scene my_scene, 'foo'
    def write_dae_from_scene(scene, file_name)
      url =  NSBundle.mainBundle.URLForResource(file_name, withExtension: 'dae')
      scene.writeToURL(url, options: nil, delegate: nil, progressHandler: nil)
    end


    # @example creating a star shape
    #   points = [
    #     [0.5, 1.0],
    #     [0.68, 0.74],
    #     [0.98, 0.65],
    #     [0.79, 0.41],
    #     [0.79, 0.1],
    #     [0.5, 0.2],
    #     [0.21, 0.1],
    #     [0.21, 0.41],
    #     [0.02, 0.65],
    #     [0.32, 0.74]
    #   ]
    #   SCNUtils.create_straight_angle_bezier_node(points, depth: 0.5)
    def create_straight_angle_bezier_node(points, params = {})
      path = NSBezierPath.bezierPath
      path.moveToPoint(points.first)

      1.upto(points.length - 1) do |i|
        path.lineToPoint(points[i])
      end

      path.closePath

      depth = params[:depth] || 1.0
      SCNNode.nodeWithGeometry(SCNShape.shapeWithPath(path, extrusionDepth: depth))
    end

    # This does not work yet
    def create_arc_node(coordinate_from, coordinate_to, radius = 30)
      vector_from = coordinate_from.to_vector
      vector_to = coordinate_to.to_vector
      point_from = [vector_from.x, vector_from.z]
      point_to = [vector_to.x, vector_to.z]

      #point_from = NSMakePoint(10, 20)
      #point_to = NSMakePoint(14, 40)

      path = NSBezierPath.bezierPath
      #NSBezierPath.setDefaultLineWidth 2.0
      path.moveToPoint point_from
      path.lineToPoint point_to
      #path.appendBezierPathWithArcFromPoint(point_from, toPoint: point_to, radius: radius)
      path.closePath

      node = SCNNode.nodeWithGeometry(SCNShape.shapeWithPath(path, extrusionDepth: 1))
      node.position = vector_from
      node
    end

    def create_line(*vectors)
      return unless vectors.length == 2

      positions = Pointer.new(SCNVector3.type, 2)
      positions[0] = vectors[0]
      positions[1] = vectors[1]
      indicies = [0,1]

      vertex_source = SCNGeometrySource.geometrySourceWithVertices(positions, count: 2)
      #index_data = NSData.dataWithBytes(indicies, length: indicies.length * SCNUtils.size_of(:int))
      index_data = NSData.dataWithBytes(indicies, length: 16) # or 8?
      element = SCNGeometryElement.geometryElementWithData(index_data, primitiveType: SCNGeometryPrimitiveTypeLine,
                                                           primitiveCount: 1, bytesPerIndex: SCNUtils.size_of(:int))
      line = SCNGeometry.geometryWithSources([vertex_source], elements: [element])

      node = SCNNode.nodeWithGeometry(line)

      mat = SCNMaterial.material
      mat.lightingModelName = SCNLightingModelConstant
      mat.diffuse.color = NSColor.whiteColor
      mat.doubleSided = true

      node.geometry.materials = [mat]
      node
    end

    def size_of(type)
      size_ptr = Pointer.new('Q')
      align_ptr = Pointer.new('Q')
      NSGetSizeAndAlignment(type, size_ptr, align_ptr)
      size_ptr[0]
    end

    def percent_pi(percent)
      Math::PI * (percent / 100)
    end

    def radians_to_degrees(radians)
      (radians * 180.0) / Math::PI
    end

    def degrees_to_radians(degrees)
      if degrees.is_a?(Array)
        degrees.map{|degree| degrees_to_radians(degree)}
      else
        degrees * (Math::Pi / 180.0)
      end
    end

  end
end

__END__

NOTES
--------------------

qreal ViewItem::rotationAngle() const {
  return 180.0/ONE_PI * atan2(transform().m12(), transform().m11());
}


qreal ViewItem::rotationAngleRadians() const {
  return atan2(transform().m12(), transform().m11());
}

It depends on what axis you are doing the rotation on.

Rotation about the z-axis is represented as:

a  = angle in radians
x' = x*cos.a - y*sin.a
y' = x*sin.a + y*cos.a
z' = z

( cos.a  sin.a  0  0)
(-sin.a  cos.a  0  0)
( 0        0    1  0)
( 0        0    0  1)
so angle should be a = atan2(transform.m12, transform.m11);

Rotation about x-axis:

a  = angle in radians
y' = y*cos.a - z*sin.a
z' = y*sin.a + z*cos.a
x' = x

(1    0      0    0)
(0  cos.a  sin.a  0)
(0 -sin.a  cos.a  0)
(0    0     0     1)
Rotation about y-axis:

a  = angle in radians
z' = z*cos.a - x*sin.a
x' = z*sin.a + x*cos.a
y' = y

(cos.a  0  -sin.a   0)
(0      1    0      0)
(sin.a  0  cos.a    0)
(0      0    0      1)




# This causes strange compiler errors
scale_constraint = SCNTransformConstraint.transformConstraintInWorldSpace(true, withBlock: block)
some_node.constraints = [scale_constraint]



values = coordinates.map do |coord|
  out = [@last_coord, coord] if @last_coord
  @last_coord = coord
  out
end.drop(1)

animation = CAKeyframeAnimation.animationWithKeyPath("position")

animation.duration = 5.0
animation.values = values
animation.delegate = self
flight_sphere.addAnimation(animation, forKey: "animation")
