**Install**

```
sudo git clone https://github.com/w1am/dotfiles.git\
  /home/$USER/Downloads/w1am && sudo chmod +x /home/$USER/Downloads/w1am/install.sh\
  && sh /home/$USER/Downloads/w1am/install.sh
```

**Language servers**
```
sudo npm install -g bash-language-server pyright vscode-langservers-extracted tsserver
```

**Diagnosis**
```
sudo npm i -g typescript-language-server; sudo npm i -g typescript
```

**Cheetsheet**
grep all files in current dir
```
grep -rni "String" *
```

grep all files using file pattern
```
grep foo **/*.js
```
