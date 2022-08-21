resource "aws_iam_role" "admin" {
  name = "admin"
  path = "/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "*"
       Principal = {
        Service = "rolesanywhere.amazonaws.com",
      }
      Effect = "Allow"
      Sid    = ""
    }]
  })
}

resource "aws_rolesanywhere_profile" "test" {

  name      = "example"
  role_arns = [aws_iam_role.test.arn]
}