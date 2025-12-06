# Supabase Products Integration Setup

## Overview

Your Flutter app now fetches product data from Supabase with full language support (English & Arabic).

## Database Setup

### 1. Create Products Table in Supabase

Run this SQL in your Supabase SQL Editor:

```sql
-- Create products table
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

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_products_lang ON public.products (lang);
CREATE INDEX IF NOT EXISTS idx_products_slug_lang ON public.products (slug, lang);

-- Enable RLS (Row Level Security)
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;

-- Create RLS policy to allow public read
CREATE POLICY "Allow public read" ON public.products
  FOR SELECT USING (true);
```

### 2. Insert Sample Data

Use the SQL script provided in your project (`products_supabase_schema.sql`) to populate the table with English and Arabic products.

## How It Works

### 1. ProductsController Fetching

The controller automatically:
- Detects the current app language
- Fetches products matching that language
- Falls back to English if the language is not found
- Shows a loading indicator while fetching
- Uses hardcoded fallback products if Supabase is unavailable

### 2. Product Model

Maps Supabase columns to the app:

```dart
// Supabase → App Model
name → product.title
intro → product.description
"reed more" → product.fullDescription
photo → product.image
lang → product.lang
slug → product.slug
```

### 3. Language Support

Products are fetched based on the app's locale:

```dart
// Get language code from current locale
final String currentLang = Get.locale?.languageCode ?? 'en';

// Fetch for that language
await SupabaseService.client
    .from('products')
    .select()
    .eq('lang', currentLang)
    .order('id', ascending: true);
```

## Product Images

### Image Requirements

- **Format**: WebP or PNG/JPG
- **Size**: Recommended 400x300 pixels
- **URL**: Must be publicly accessible HTTPS URL
- **Location**: Can be hosted on:
  - Supabase Storage (built-in)
  - AWS S3
  - Cloudinary
  - Any CDN with CORS enabled

### Using Supabase Storage for Images

1. **Upload image to Supabase Storage:**
   - Go to Storage → Create new bucket (name: `products`)
   - Make bucket public
   - Upload images

2. **Get public URL:**
   ```
   https://your-project.supabase.co/storage/v1/object/public/products/escalator.webp
   ```

3. **Store URL in database:**
   ```sql
   UPDATE products SET photo = 'https://your-project.supabase.co/storage/v1/object/public/products/escalator.webp'
   WHERE slug = 'escalator' AND lang = 'en';
   ```

## Language Switching

When user changes language, products automatically refresh:

1. App's locale changes
2. ProductsController detects change
3. `onLanguageChange()` is called
4. `fetchProducts()` runs with new language
5. UI updates with new products

## Error Handling

### Scenario 1: Supabase Unreachable
- Falls back to hardcoded products
- Shows error message (optional)
- App continues to work

### Scenario 2: Language Not Found
- Automatically falls back to English
- No error shown to user
- Smooth experience

### Scenario 3: Image Load Fails
- Shows placeholder with broken image icon
- Doesn't break the page
- User can still read product info

## Testing Locally

### 1. Check if Products Load

```bash
# In your app, open browser console (F12)
# Look for network requests to Supabase
# Check if products array is populated
```

### 2. Test Language Switching

```dart
// In app_translations.dart or where you handle language
// Change language and observe products updating
Get.updateLocale(Locale('ar')); // Arabic
Get.updateLocale(Locale('en')); // English
```

### 3. Debug Network Requests

Add this to ProductsController for debugging:

```dart
print('Fetching products for language: $currentLang');
print('Response: ${response.length} products');
productsList.forEach((p) => print('- ${p.title}'));
```

## Troubleshooting

### Products Not Showing

**Problem**: Grid shows no products

**Solutions**:
1. Check Supabase connection in `lib/config/supabase_config.dart`
2. Verify RLS policies allow public read
3. Check browser console for errors
4. Ensure `lang` column matches your app's locale code

### Images Not Loading

**Problem**: Products show but no images

**Solutions**:
1. Verify image URLs in database are correct HTTPS URLs
2. Check CORS headers on image host
3. Try different image format (WebP → PNG)
4. Use browser DevTools Network tab to inspect image requests

### Wrong Language Showing

**Problem**: App shows English but database has Arabic products

**Solutions**:
1. Check `Get.locale?.languageCode` returns 'ar' not 'ar_EG'
2. Verify database has 'ar' language code (not 'ar_EG')
3. Update language code in database or app to match

## Database Schema Reference

```
Table: products
├── id (BIGINT) - Auto-increment primary key
├── name (TEXT) - Product name/title
├── intro (TEXT) - Short description
├── reed more (TEXT) - Full description
├── photo (TEXT) - Image URL
├── lang (TEXT) - Language code (en/ar)
├── slug (TEXT) - URL-friendly name
├── created_at (TIMESTAMP) - Auto timestamp
└── UNIQUE(slug, lang) - Ensures no duplicate products per language
```

## Performance Optimization

### Caching Products

Currently products are fetched every time controller initializes. To cache:

```dart
// Add to ProductsController
final Map<String, List<ProductModel>> _cache = {};

Future<void> fetchProducts() async {
  final String currentLang = Get.locale?.languageCode ?? 'en';
  
  // Return cached data if available
  if (_cache.containsKey(currentLang)) {
    productsList.value = _cache[currentLang]!;
    return;
  }
  
  // ... fetch from Supabase ...
  _cache[currentLang] = productsList.value;
}
```

### Pagination (for large datasets)

```dart
const int pageSize = 10;
int currentPage = 0;

Future<void> fetchProducts({int page = 0}) async {
  final response = await SupabaseService.client
      .from('products')
      .select()
      .eq('lang', currentLang)
      .range(page * pageSize, (page + 1) * pageSize - 1);
  // ...
}
```

## API Reference

### ProductsController Methods

```dart
// Fetch products for current language
Future<void> fetchProducts()

// Refresh products when language changes
void onLanguageChange()

// Get all products (with fallback)
List<ProductModel> get products
```

### ProductModel Properties

```dart
String? id              // Database ID
String image            // Photo URL
String title            // Product name
String description      // Short intro
String? fullDescription // Full "reed more" text
String? lang            // Language code
String? slug            // URL slug
```

## Files Modified

```
lib/models/product_model.dart           - Enhanced with Supabase fields
lib/controllers/products_controller.dart - Added Supabase fetching
lib/view/products&solutions.dart        - Added loading state & network images
lib/view/product_details.dart           - Display full descriptions
```

## Next Steps

1. ✅ Create products table in Supabase
2. ✅ Insert English and Arabic data
3. ✅ Upload product images to Supabase Storage or CDN
4. ✅ Test locally with `flutter run`
5. ✅ Build and deploy: `flutter build web --release`
6. ✅ Test on production

## Support

For issues:
1. Check Supabase dashboard for data
2. Verify RLS policies
3. Check browser console for errors
4. Inspect Network tab for failed requests
