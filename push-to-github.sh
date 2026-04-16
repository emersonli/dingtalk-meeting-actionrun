#!/bin/bash

# Push to GitHub script
# Repository: https://github.com/emersonli/dingtalk-meeting-actionrun

echo "📦 Pushing DingTalk Action Items to GitHub..."
echo ""
echo "Repository: https://github.com/emersonli/dingtalk-meeting-actionrun"
echo ""

# Check if we're in the right directory
if [ ! -f "action-items.md" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

# Set remote URL
git remote set-url origin https://github.com/emersonli/dingtalk-meeting-actionrun.git

# Push to GitHub
echo "🚀 Pushing to GitHub..."
git push -u origin main --force

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Success! Your code has been pushed to:"
    echo "   https://github.com/emersonli/dingtalk-meeting-actionrun"
    echo ""
    echo "Next steps:"
    echo "1. Visit the repository on GitHub"
    echo "2. Add a description and topics"
    echo "3. Share with your team!"
else
    echo ""
    echo "❌ Push failed. Please try manually:"
    echo ""
    echo "   git push -u origin main --force"
    echo ""
    echo "Or use GitHub CLI:"
    echo "   gh repo create emersonli/dingtalk-meeting-actionrun --public --source=. --push"
fi
