# بسم الله الرحمن الرحيم
# la ilaha illa Allah Mohammed Rassoul Allah

import smtplib
from email.mime.text import MIMEText
from getpass import getpass

subject = "Email Subject"
body = "This is the body of the text message"
sender = "killdeady98@gmail.com"
recipients = ["ouhamouy1098@gmail.com"]


def send_email(subject, body, sender, recipients, password):
   msg = MIMEText(body)
   msg['Subject'] = subject
   msg['From'] = sender
   msg['To'] = ', '.join(recipients)
   with smtplib.SMTP_SSL('smtp.gmail.com', 465) as smtp_server:
      smtp_server.ehlo()
      smtp_server.login(sender, password)
      smtp_server.sendmail(sender, recipients, msg.as_string())
   print("Message sent!")


send_email(subject, body, sender, recipients, getpass())
