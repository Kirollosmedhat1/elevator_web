#!/bin/bash

# Deployment Script for Flutter Web with Video Fix
# This script builds and prepares your app for deployment

set -e

PROJECT_DIR="/Users/kiro/Developer/lib/elevatorweb"
BUILD_DIR="$PROJECT_DIR/build/web"

echo "🚀 Flutter Web Deployment Script"
echo "================================="
echo ""

# Step 1: Clean and prepare
echo "📦 Step 1: Cleaning and preparing project..."
cd "$PROJECT_DIR"
flutter clean
flutter pub get
echo "✅ Project prepared"
echo ""

# Step 2: Build web release
echo "🔨 Step 2: Building Flutter web (release mode)..."
flutter build web --release
echo "✅ Web build complete"
echo ""

# Step 3: Display build output
echo "📊 Step 3: Build output summary"
echo "================================="
echo "Build directory: $BUILD_DIR"
echo ""
echo "Build size breakdown:"
du -sh "$BUILD_DIR" | awk '{print "Total size: " $1}'
echo ""

# Step 4: Show deployment options
echo "🌐 Step 4: Deployment Options"
echo "================================="
echo ""
echo "Option 1: Deploy to GitHub Pages"
echo "---------------------------------"
echo "The build/web folder is ready to deploy."
echo "If using GitHub Pages, push the build/web contents to gh-pages branch:"
echo ""
echo "  git push origin 'git subtree split --prefix build/web main':gh-pages --force"
echo ""

echo "Option 2: Deploy to Netlify"
echo "---------------------------------"
echo "Connected to your Netlify site and deploy from build/web:"
echo "  netlify deploy --prod --dir=build/web"
echo ""

echo "Option 3: Manual Deployment"
echo "---------------------------------"
echo "Upload the entire build/web folder to your hosting provider"
echo ""

echo "📝 Important Notes:"
echo "==================="
echo "1. Ensure your videos are hosted on CORS-enabled servers (Supabase, AWS S3, etc.)"
echo "2. Test locally first: python3 -m http.server 8000 -d build/web"
echo "3. Open browser console (F12) to check for any video loading errors"
echo "4. Videos must be HTTPS (not HTTP) on production"
echo ""

echo "🎉 Build ready for deployment!"
echo "Build location: $BUILD_DIR"
echo ""
