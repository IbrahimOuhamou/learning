<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>بسم الله الرحمن الرحيم</title>

    <style>
      table {
        text-align: center;
        margin: auto;
        width: 80vw;
        empty-cells: hide;
        table-layout: fixed;
        th, td {
          border: solid;
          border-radius: .4rem;
          border-collapse: collapse;
        }
      }
    </style>

  </head>
  <body>
    <p>بسم الله الرحمن الرحيم</p>

    <div>
      <p>bismi_allah_integer: <b>{{ $.bismi_allah.bismi_allah_integer }}</b></p>
      <p>bismi_allah_string: <b>{{ $.bismi_allah.bismi_allah_string }}</b></p>
      <p>bismi_allah_text: <b>{{ $.bismi_allah.bismi_allah_text }}</b></p>
    </div>

  </body>
</html>
