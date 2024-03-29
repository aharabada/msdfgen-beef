using System;

namespace msdfgen
{
	public struct Bitmap<T, N> : IDisposable where N : const int
	{
		public T* Pixels;
		public int32 Width, Height;

		public this() => this = default;

		public this(int32 width, int32 height)
		{
			Width = width;
			Height = height;

			Pixels = new T[N * Width * Height]*;
		}

		public void Dispose()
		{
			delete (void*)Pixels;
		}
	}
}
