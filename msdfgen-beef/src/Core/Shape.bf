using System;
namespace msdfgen
{
	[CRepr]
	public struct Shape
	{
		[CRepr]
		public struct Bounds
		{
			public double Left;
			public double Bottom;
			public double Right;
			public double Top;
		}

		// msdfgen_SizeOfShape
		uint8[40] arr;

		public void Normalize() mut
		{
			msdfgen_shape_normalize(&this);
		}

		public bool Validate() mut
		{
			return msdfgen_shape_validate(&this);
		}

		public bool ReverseIfNeeded(in Bounds bounds) mut
		{
			return msdfgen_shape_reverseIfNeeded(&this, &bounds);
		}

		public Bounds GetBounds() mut => msdfgen_shape_getBounds(&this);

		public void OrientContours() mut => msdfgen_shape_orientContours(&this);
		
		[CLink]
		private static extern void msdfgen_shape_normalize(Shape* shape);

		[CLink]
		private static extern Bounds msdfgen_shape_getBounds(Shape* shape);

		[CLink]
		private static extern bool msdfgen_shape_validate(Shape* shape);
		
		[CLink]
		private static extern bool msdfgen_shape_reverseIfNeeded(Shape* shape, Bounds* bounds);

		[CLink]
		private static extern void msdfgen_shape_orientContours(Shape* shape);
	}
}
