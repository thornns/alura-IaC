resource "aws_s3_bucket" "dockerrun" {
  bucket = "${var.reponame}-dockerrun-beanstalk-json-999898949736"
}

resource "aws_s3_object" "dockerrun_json" {
  depends_on = [aws_s3_bucket.dockerrun]

  bucket = "${var.reponame}-dockerrun-beanstalk-json-999898949736"
  key    = "${var.reponame}.zip"

  # Como vamos executar o main.tf dentro do diretório Prod, não precisa de caminho.
  source = "${var.reponame}.zip"

  # Vai fazer um md5 do arquivo e só vai fazer upload se for diferente do que já existe
  etag = filemd5("${var.reponame}.zip")
}