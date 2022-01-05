#include "stub.h"

void msdfgen_generateSDF(const BitmapRef<float, 1> *output, const Shape *shape, const Projection *projection, double range, const GeneratorConfig *config)
{
    generateSDF(*output, *shape, *projection, range, *config);
}

void msdfgen_generateMSDF(const BitmapRef<float, 3> *output, const Shape *shape, const Projection *projection, double range, const MSDFGeneratorConfig *config)
{
    generateMSDF(*output, *shape, *projection, range, *config);
}

bool msdfgen_loadGlyph(Shape *output, FontHandle *font, GlyphIndex glyphIndex, double *advance)
{
    *output = Shape();

    return loadGlyph(*output, font, glyphIndex, advance);
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

bool msdfgen_shape_validate(Shape* shape)
{
    return shape->validate();
}

bool msdfgen_shape_reverseIfNeeded(Shape* shape, Shape::Bounds* bounds)
{
    // Determine if shape is winded incorrectly and reverse it in that case
    msdfgen::Point2 outerPoint(bounds->l - (bounds->r - bounds->l) - 1, bounds->b - (bounds->t - bounds->b) - 1);
    if (msdfgen::SimpleTrueShapeDistanceFinder::oneShotDistance(*shape, outerPoint) > 0)
    {
        for (msdfgen::Contour& contour : shape->contours)
            contour.reverse();

        return true;
    }

    return false;
}

void msdfgen_shape_orientContours(Shape* shape)
{
    shape->orientContours();
}

bool msdfgen_resolveShapeGeometry(Shape* shape)
{
    return msdfgen::resolveShapeGeometry(*shape);
}
