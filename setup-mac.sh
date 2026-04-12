#!/bin/bash
# acorn 개발 환경 Mac 초기 세팅 스크립트
# 사용법: bash setup-mac.sh

set -e

echo "🌰 acorn 개발 환경 세팅 시작..."

# 1. 레포 클론
echo "📦 레포 클론 중..."
mkdir -p ~/dotoricode
cd ~/dotoricode

[ -d "acorn" ] || git clone https://github.com/dotoricode/acorn
[ -d "dotfiles" ] || git clone https://github.com/dotoricode/dotfiles

# 2. ~/.claude 디렉토리 준비
echo "📁 .claude 디렉토리 준비 중..."
mkdir -p ~/.claude/skills

# 3. harness 심링크 연결
echo "🔗 harness 심링크 연결 중..."
if [ -L ~/.claude/skills/harness ]; then
    echo "   이미 연결됨, 스킵"
elif [ -d ~/.claude/skills/harness ]; then
    mv ~/.claude/skills/harness ~/.claude/skills/harness-backup
    ln -s ~/dotoricode/dotfiles/claude/harness ~/.claude/skills/harness
else
    ln -s ~/dotoricode/dotfiles/claude/harness ~/.claude/skills/harness
fi

# 4. vendors 디렉토리 생성 (gitignore 대상)
echo "📂 vendors 디렉토리 생성 중..."
mkdir -p ~/dotoricode/dotfiles/claude/harness/vendors/gstack
mkdir -p ~/dotoricode/dotfiles/claude/harness/vendors/omc
mkdir -p ~/dotoricode/dotfiles/claude/harness/vendors/ecc
mkdir -p ~/dotoricode/dotfiles/claude/harness/backup

# 5. harness.lock에서 SHA 읽어서 gstack clone
echo "📥 gstack 설치 중..."
GSTACK_SHA=$(cat ~/dotoricode/dotfiles/claude/harness/harness.lock | python3 -c "import sys,json; print(json.load(sys.stdin)['tools']['gstack']['commit'])")

if [ -z "$(ls -A ~/dotoricode/dotfiles/claude/harness/vendors/gstack)" ]; then
    git clone https://github.com/garrytan/gstack /tmp/gstack-tmp
    cd /tmp/gstack-tmp
    git checkout $GSTACK_SHA
    cp -r /tmp/gstack-tmp/. ~/dotoricode/dotfiles/claude/harness/vendors/gstack/
    rm -rf /tmp/gstack-tmp
    echo "   gstack @ $GSTACK_SHA 설치 완료"
else
    echo "   이미 설치됨, 스킵"
fi

# 6. gstack 심링크 연결
echo "🔗 gstack 심링크 연결 중..."
if [ -L ~/.claude/skills/gstack ]; then
    echo "   이미 연결됨, 스킵"
else
    ln -s ~/dotoricode/dotfiles/claude/harness/vendors/gstack ~/.claude/skills/gstack
fi

# 7. settings.json 심링크 연결
echo "⚙️  settings.json 연결 중..."
if [ -f ~/.claude/settings.json ]; then
    mv ~/.claude/settings.json ~/.claude/settings.json.backup
fi
ln -sf ~/dotoricode/dotfiles/claude/settings.json ~/.claude/settings.json

# 8. acorn Node.js 의존성 설치
echo "📦 acorn 의존성 설치 중..."
cd ~/dotoricode/acorn
npm install

echo ""
echo "✅ 세팅 완료!"
echo ""
echo "현재 상태:"
echo "  ~/.claude/skills/harness → $(readlink ~/.claude/skills/harness)"
echo "  ~/.claude/skills/gstack  → $(readlink ~/.claude/skills/gstack)"
echo "  ~/.claude/settings.json  → $(readlink ~/.claude/settings.json)"
echo ""
echo "다음 단계: Claude Code를 D:\dotoricode\acorn 에서 실행"