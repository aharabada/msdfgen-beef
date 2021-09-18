using System;

namespace msdfgen
{
	public struct GeneratorConfig
	{
		public bool OverlapSupport;

		public this(bool overlapSupport = true)
		{
			OverlapSupport = overlapSupport;
		}
	}

	[CRepr]
	public struct MSDFGeneratorConfig : GeneratorConfig
	{
	    /// Configuration of the error correction pass.
	    public ErrorCorrectionConfig ErrorCorrection;

		public this() => this = default;

		public this(bool overlapSupport, ErrorCorrectionConfig errorCorrection = .Default)
		{
			OverlapSupport = overlapSupport;
			ErrorCorrection = errorCorrection;
		}
	}

	[CRepr]
	public struct ErrorCorrectionConfig
	{
	    /// The default value of minDeviationRatio.
	    public const double DefaultMinDeviationRatio = 1.11111111111111111;
	    /// The default value of minImproveRatio.
	    public const double DefaultMinImproveRatio = 1.11111111111111111;

	    /// Mode of operation.
	    public enum Mode : uint32
		{
	        /// Skips error correction pass.
	        DISABLED,
	        /// Corrects all discontinuities of the distance field regardless if edges are adversely affected.
	        INDISCRIMINATE,
	        /// Corrects artifacts at edges and other discontinuous distances only if it does not affect edges or corners.
	        EDGE_PRIORITY,
	        /// Only corrects artifacts at edges.
	        EDGE_ONLY
	    }

		public Mode Mode;

	    /// Configuration of whether to use an algorithm that computes the exact shape distance at the positions of suspected artifacts. This algorithm can be much slower.
	    public enum DistanceCheckMode : uint32
		{
	        /// Never computes exact shape distance.
	        DO_NOT_CHECK_DISTANCE,
	        /// Only computes exact shape distance at edges. Provides a good balance between speed and precision.
	        CHECK_DISTANCE_AT_EDGE,
	        /// Computes and compares the exact shape distance for each suspected artifact.
	        ALWAYS_CHECK_DISTANCE
	    }

		public DistanceCheckMode DistanceCheckMode;

	    /// The minimum ratio between the actual and maximum expected distance delta to be considered an error.
	    public double MinDeviationRatio;
	    /// The minimum ratio between the pre-correction distance error and the post-correction distance error. Has no effect for DO_NOT_CHECK_DISTANCE.
	    public double MinImproveRatio;
	    /// An optional buffer to avoid dynamic allocation. Must have at least as many bytes as the MSDF has pixels.
	    public uint8* Buffer;

		public this(Mode mode = .EDGE_PRIORITY, DistanceCheckMode distanceCheckMode = .CHECK_DISTANCE_AT_EDGE,
			double minDeviationRatio = DefaultMinDeviationRatio, double minImproveRatio = DefaultMinImproveRatio, uint8* buffer = null)
		{
			Mode = mode;
			DistanceCheckMode = distanceCheckMode;
			MinDeviationRatio = minDeviationRatio;
			MinImproveRatio = minImproveRatio;
			Buffer = buffer;
		}

		public static Self Default = .();
	}
}
