## Sobre
Trata-se de um projeto simples, feito 100% em arquitetura MVC, que tem a finalidade de gerar gráficos personalizáveis.

## Ferramentas
- Delphi 10.4 Community Edition e seus componentes nativos;
- MySQL Server Community Edition.

## Instalação
1) Para compilar o projeto, é necessário Delphi 10.4 ou superior. Também é necessário o pacote TeeChart VCL/FMX Standard, que acompanha as edições mais completas do Delphi. No caso de possuir as edições community ou padrão, instalar manulamente uma versão trial do pacote, que pode ser obtida [aqui](https://www.steema.com/downloads/vcl) a partir de fontes oficiais.
2) Instalar do banco de dados [MySQL Server 8.0 x86](https://dev.mysql.com/get/Downloads/MySQLInstaller/mysql-installer-web-community-8.0.29.0.msi) ou [MariaDb](https://mariadb.org/download/?t=mariadb&p=mariadb&r=10.8.3&os=windows&cpu=x86_64&pkg=msi&m=fder)
3) Utilizar qualquer ferramenta que consiga acessar o banco de dados e criar um novo schema com qualquer nome, preferencialmente com codificação utf-8
4) Editar o arquivo .ini no diretório bin e preencher as informações de acesso ao banco de dados.
5) Ao executar o projeto, se tudo der certo, aparecerá na tela um dialog perguntando se deseja criar a estrutura de tabelas.
