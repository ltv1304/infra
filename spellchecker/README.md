# Spellcheker
Docker образ для использования в составе devcontainer при разработке тектовых документов для проверки правописания

При использовании huspell нужно указывать кодировку

```bash
hunspell -d ru_RU -i UTF-8 -l < report/search.md
```
Для использования cspell нужен конфиг


Для работы/улучшения инструмента можно обратиться к следующим материалам:
- [git: репозиторий languagetool-node](https://github.com/343dev/languagetool-node);
- [git: репозиторий languagetool](https://github.com/languagetool-org/languagetool);
- [git: репозиторий hunspell](https://github.com/hunspell/hunspell);
- [habr: автоматизируем проверку орфографии](https://habr.com/ru/companies/flant/articles/806629/);
- [habr: cspell](https://habr.com/ru/articles/809889/);
- [habr: cspell](https://habr.com/ru/articles/902236/)
- [habr: hunspell](https://habr.com/ru/companies/flant/articles/920148/);
- [doc: cspell](https://cspell.org/);
- [blog: использование cspell](https://ra1ahq.blog/paketnaya-proverka-orfografii-v-failakh-markdown-s-pomoshyu-besplatnogo-spell-chekera-cspell);
- [doc: languagetool](https://dev.languagetool.org/);
- [blog: DocOps](https://annjulyleon.github.io/docops/docops-spelling/)

