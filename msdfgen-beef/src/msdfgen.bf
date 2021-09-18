using System;
using FreeType;
using System.Diagnostics;

namespace msdfgen
{
	class msdfgen
	{
#if DEBUG
		static this()
		{
			// Make sure our (fake) Shape struct has the same size as the C++-Shape struct
			Debug.Assert(sizeof(Shape) == msdfgen_SizeOfShape);
		}
#endif

		[CLink]
		private static extern void msdfgen_loadGlyph(Shape *output, FT_Face *font, uint32 glyphIndex, double *advance);
		
		[CLink]
		private static extern void msdfgen_generateMSDF([MangleConst] Bitmap<float, const 3> *output, [MangleConst] Shape *shape, [MangleConst] Projection *projection, double range, [MangleConst] MSDFGeneratorConfig *config);

		//[CLink]
		//private static extern void msdfgen_generateSDF([MangleConst] Bitmap<float, const 1> *output, [MangleConst] Shape *shape, [MangleConst] Projection *projection, double range, [MangleConst] GeneratorConfig *config);

		[CLink]
		private static extern uint msdfgen_SizeOfShape;
		
		[CLink]
		private static extern void msdfgen_edgeColoringSimple(Shape* shape, double angleThreshold, uint64 seed);
		
		public static void LoadGlyph(out Shape shape, in FT_Face font, uint32 glyphIndex, out double advance)
		{
			shape = ?;
			advance = ?;

#unwarn
			msdfgen_loadGlyph(&shape, &font, glyphIndex, &advance);
		}

		public static void GenerateMSDF(in Bitmap<float, const 3> output, in Shape shape, in Projection projection, double range, in MSDFGeneratorConfig config)
		{
#unwarn
			msdfgen_generateMSDF(&output, &shape, &projection, range, &config);
		}

		public static void EdgeColoringSimple(in Shape shape, double angleThreshold, uint64 seed = 0)
		{
#unwarn
			msdfgen_edgeColoringSimple(&shape, angleThreshold, seed);
		}
	}
}