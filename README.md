# bashrc
=

bash設定ファイルのメモ

Debianデフォルトのbashrcをベースにしています．

## 導入

```bash
# 自動
bash -c "$(curl -fsSL https://raw.github.com/TNaky/bashrc/master/install.sh)"
```

```bash
# 手動
git clone https://github.com/TNaky/bashrc.git ${HOME}/.bash
ln -s .bash/bashrc ${HOME}/.bashrc
ln -s ${HOME}/.bash/bash_profile ${HOME}/.bash_profile
ln -s ${HOME}/.bash/inputrc ${HOME}/.inputrc
