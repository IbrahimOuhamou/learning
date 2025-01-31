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

    <div style="border: solid;">
      <form method="POST" action="#">
        <label for="bismi_allah_string">bismi_allah_string</label>
        <input type="text" name="bismi_allah_string" id="bismi_allah_string">
        <br />
        <label for="bismi_allah_text">bismi_allah_text</label>
        <input type="text" name="bismi_allah_text" id="bismi_allah_text">
        <br />
        <button type="submit">bismi Allah submit</button>
      </form>
    </div>

    <table>
      <tr>
        <th>id</th>
        <th>bismi_allah_string</th>
        <th>bismi_allah_text</th>
      </tr>
      @for ($.bismi_allah_data) |bismi_allah| {
        <tr>
          <td><a href="/bismi_allah_db/{{ bismi_allah.id }}">{{ bismi_allah.id }}</a></td>
          <td>{{ bismi_allah.bismi_allah_string }}</td>
          <td>{{ bismi_allah.bismi_allah_text }}</td>
        </tr>
      }
    </table>

  </body>
</html>
