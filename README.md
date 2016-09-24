# bashrc
=

bash設定ファイルのメモ

Debianデフォルトのbashrcをベースにしています．

## 導入

# 自動
bash -c "$(curl -fsSL https://raw.github.com/TNaky/bashrc/master/install.sh)"
```bash
# 手動
git clone https://github.com/TNaky/bashrc.git ${HOME}/.bash
ln -s .bash/bashrc ${HOME}/.bashrc
