#include "stub.h"

void msdfgen_generateSDF(const BitmapRef<float, 1> *output, const Shape *shape, const Projection *projection, double range, const GeneratorConfig *config)
{
    generateSDF(*output, *shape, *projection, range, *config);
}

void msdfgen_generateMSDF(const BitmapRef<float, 3> *output, const Shape *shape, const Projection *projection, double range, const MSDFGeneratorConfig *config)
{
    generateMSDF(*output, *shape, *projection, range, *config);
}

void msdfgen_loadGlyph(Shape *output, FontHandle *font, GlyphIndex glyphIndex, double *advance)
{
    *output = Shape();

    loadGlyph(*output, font, glyphIndex, advance);
}

void msdfgen_shape_normalize(Shape *shape)
{
    shape->normalize();
}

void msdfgen_edgeColoringSimple(Shape *shape, double angleThreshold, unsigned long long seed)
{
    edgeColoringSimple(*shape, angleThreshold, seed);
}

Shape::Bounds msdfgen_shape_getBounds(Shape *shape)
{
    return shape->getBounds();
}
