#pragma once

// Stub to build a c library for msdfgen

#define MSDFGEN_USE_SKIA

#if defined __cplusplus
    #define EXTERN extern "C"
#else
    #define EXTERN extern
#endif

#include "msdfgen/msdfgen.h"
#include "msdfgen/msdfgen-ext.h"
#include "msdfgen/core/ShapeDistanceFinder.h"

using namespace msdfgen;

EXTERN void msdfgen_generateSDF(const BitmapRef<float, 1> *output, const Shape *shape, const Projection *projection, double range, const GeneratorConfig *config);

EXTERN void msdfgen_generateMSDF(const BitmapRef<float, 3> *output, const Shape *shape, const Projection *projection, double range, const MSDFGeneratorConfig *config);

EXTERN bool msdfgen_loadGlyph(Shape *output, FontHandle *font, GlyphIndex glyphIndex, double *advance);

EXTERN const size_t msdfgen_SizeOfShape = sizeof(Shape);

EXTERN void msdfgen_edgeColoringSimple(Shape *shape, double angleThreshold, unsigned long long seed);

EXTERN void msdfgen_shape_normalize(Shape *shape);

EXTERN Shape::Bounds msdfgen_shape_getBounds(Shape *shape);

EXTERN bool msdfgen_shape_validate(Shape* shape);

EXTERN bool msdfgen_shape_reverseIfNeeded(Shape* shape, Shape::Bounds* bounds);

EXTERN void msdfgen_shape_orientContours(Shape* shape);

EXTERN bool msdfgen_resolveShapeGeometry(Shape* shape);
