# Quick Start: Supabase Products Integration

## 🚀 5-Minute Setup

### Step 1: Create Database Table (Supabase Console)

Go to SQL Editor in Supabase and run:

```sql
CREATE TABLE IF NOT EXISTS public.products (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  intro TEXT,
  "reed more" TEXT,
  photo TEXT,
  lang TEXT NOT NULL DEFAULT 'en',
  slug TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(slug, lang)
);

CREATE INDEX idx_products_lang ON public.products (lang);
CREATE INDEX idx_products_slug_lang ON public.products (slug, lang);

ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read" ON public.products
  FOR SELECT USING (true);
```

### Step 2: Insert English Products

```sql
INSERT INTO public.products (name, intro, "reed more", photo, lang, slug) VALUES
('Escalator', 'Smart and efficient vertical mobility solutions...', 'Full description here', 'https://example.com/escalator.webp', 'en', 'escalator'),
('Home Elevators', 'Elegant solutions for private homes...', 'Full description here', 'https://example.com/home.webp', 'en', 'home-elevators'),
-- Add more products...
```

### Step 3: Insert Arabic Products

```sql
INSERT INTO public.products (name, intro, "reed more", photo, lang, slug) VALUES
('سلم كهربائي', 'حلول ذكية وفعّالة...', 'الوصف الكامل', 'https://example.com/escalator.webp', 'ar', 'salm-kahrabaei'),
('المصاعد المنزلية', 'حلول أنيقة...', 'الوصف الكامل', 'https://example.com/home.webp', 'ar', 'almasae-almanzilia'),
-- Add more products...
```

### Step 4: Verify in App

```bash
cd /Users/kiro/Developer/lib/elevatorweb
flutter run

# In app: Switch language and see products update
```

## 📋 Important Column Names

Use EXACTLY these names in Supabase:

| Field | Type | Purpose |
|-------|------|---------|
| `id` | BIGINT | Auto-increment ID |
| `name` | TEXT | Product title |
| `intro` | TEXT | Short description (shows in grid) |
| `"reed more"` | TEXT | Full description (shows in details) |
| `photo` | TEXT | Image URL |
| `lang` | TEXT | Language code: `en` or `ar` |
| `slug` | TEXT | URL-friendly ID (must be unique with lang) |

## 🖼️ Image URLs

Must be publicly accessible HTTPS URLs:

```
✅ https://example.com/image.webp
✅ https://cdn.example.com/products/image.png
✅ https://your-project.supabase.co/storage/v1/object/public/products/image.webp

❌ http://example.com/image.webp (must be HTTPS)
❌ /local/path/image.png (must be full URL)
```

## 🔍 Testing Checklist

- [ ] Table created in Supabase
- [ ] Products inserted for English (`lang: 'en'`)
- [ ] Products inserted for Arabic (`lang: 'ar'`)
- [ ] Image URLs are accessible (test in browser)
- [ ] RLS policy allows public read
- [ ] App running locally shows products
- [ ] Language switch updates products
- [ ] Images display correctly

## ❌ Common Issues & Fixes

### Products not showing

```dart
// Check ProductsController console output
// Should show: "Fetching products for language: en"
// Should show: "Response: X products"
```

**Fix**: Verify lang values in database match your locale

### Images not loading

**Fix**: 
1. Copy image URL to browser address bar
2. If image loads, issue is CORS
3. If 404 error, URL is wrong
4. If "403 Forbidden", image isn't public

### Wrong language showing

**Fix**: Ensure language code is exactly `'en'` or `'ar'` (lowercase)

## 📱 How It Works in App

```
User opens app
     ↓
ProductsController created
     ↓
onInit() calls fetchProducts()
     ↓
Gets current language: Get.locale?.languageCode
     ↓
Queries Supabase: WHERE lang = 'en' (or 'ar')
     ↓
ProductModel.fromMap() maps Supabase → App
     ↓
Grid displays products
     ↓
User changes language
     ↓
onLanguageChange() calls fetchProducts()
     ↓
Cycle repeats with new language
```

## 💾 SQL Ready-to-Copy

### Full Setup (Table + Indexes + RLS)

```sql
CREATE TABLE IF NOT EXISTS public.products (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  intro TEXT,
  "reed more" TEXT,
  photo TEXT,
  lang TEXT NOT NULL DEFAULT 'en',
  slug TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(slug, lang)
);

CREATE INDEX IF NOT EXISTS idx_products_lang ON public.products (lang);
CREATE INDEX IF NOT EXISTS idx_products_slug_lang ON public.products (slug, lang);

ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read" ON public.products
  FOR SELECT USING (true);

-- Add English product
INSERT INTO public.products (name, intro, "reed more", photo, lang, slug) 
VALUES ('Product Name', 'Short intro', 'Full description', 'https://url.com/image.webp', 'en', 'product-slug')
ON CONFLICT (slug, lang) DO UPDATE SET 
  name = EXCLUDED.name, 
  intro = EXCLUDED.intro, 
  "reed more" = EXCLUDED."reed more", 
  photo = EXCLUDED.photo;

-- Add Arabic product (same slug, different lang)
INSERT INTO public.products (name, intro, "reed more", photo, lang, slug) 
VALUES ('اسم المنتج', 'وصف قصير', 'الوصف الكامل', 'https://url.com/image.webp', 'ar', 'product-slug')
ON CONFLICT (slug, lang) DO UPDATE SET 
  name = EXCLUDED.name, 
  intro = EXCLUDED.intro, 
  "reed more" = EXCLUDED."reed more", 
  photo = EXCLUDED.photo;
```

## 📞 Support

Issues? Check:
1. Supabase dashboard → products table exists
2. RLS policy allows SELECT
3. Language codes are 'en' or 'ar' (lowercase)
4. Image URLs are HTTPS and accessible
5. Browser console for errors (F12)

## 🎉 Success!

When it's working, you'll see:
- ✅ Products load without hardcoding
- ✅ Language switching works instantly
- ✅ Different content for English & Arabic
- ✅ Images display correctly
- ✅ Full descriptions in detail pages

---

**Next**: See `SUPABASE_PRODUCTS_SETUP.md` for detailed setup instructions
