# Linked Lang
[Linked Data](https://www.w3.org/DesignIssues/LinkedData)を用いて記述するプログラミング言語の、[JSON-LD](https://www.w3.org/TR/json-ld/)による実装です。  
各種の命令や演算、データをLinked Dataのノードとして記述します。

## Reqirements
実行にはRubyが必要です。  

動作確認済みのバージョン:
- ruby 3.3.7 \[x86_64-linux\]

## Installation
1. Rubyの実行環境を用意します。  
   [rbenv](https://github.com/rbenv/rbenv)を利用すると便利ですが必須ではありません。  
1. `git clone`などでリポジトリのディレクトリ全体をコピーします。  
1. 以下のいずれかの方法で依存gemをインストールします。  
   - 直接`gem`コマンドを用いる場合  
     ```bash
     gem install json-ld
     ```
   - bundlerを利用する場合  
     リポジトリのルートディレクトリに移動し、必要に応じてbundlerの設定をしてから
     ```bash
     bundle install
     ```

## Usage
Linked Langのソースコードをテキストファイルに記述し、ソースファイルのパスを渡して`linked_lang.rb`を実行します。  
```bash
ruby linked_lang.rb <source-file>
```
Shebangを解釈可能なシェルであれば、以下のように直接実行することも可能です。  
```bash
./linked_lang.rb <source-file>
```

## Syntax
Linked LangおよびJSON-LD実装の構文や仕様については、docsディレクトリ内の[syntax.md](docs/syntax.md)および[node_types.md](docs/node_types.md)を参照して下さい。

## Samples
- [`hello.jsonld`](samples/hello.jsonld)  
  いわゆるHello Worldです。実行すると`Hello Linked World!`の文字列が改行付きで出力されます。  
- [`hello_verbose.jsonld`](samples/hello_verbose.jsonld)  
  `hello.jsonld`と等価なプログラムですが、contextを利用せずIRIやJSON-LDキーワードを省略無しで記述しています。  
- [`fizzbuzz.jsonld`](samples/fizzbuzz.jsonld)  
  FizzBuzzです。最初に標準入力から整数を受け取り、その数までのFizzBuzzを出力します。

## Contact
バグ報告や言語機能の提案などは[Twitter\(現X\)](https://x.com/boku_renraku)等でお声掛け下さい。
