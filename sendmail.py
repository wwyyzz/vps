import smtplib
from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText
from email.MIMEBase import MIMEBase
from email import encoders
 
fromaddr = "wwyyzz08"
toaddr = "wwyyzz08@sina.com"
 
msg = MIMEMultipart()
 
msg['From'] = fromaddr
msg['To'] = toaddr
msg['Subject'] = "ikev2-vpn"
 
body = "ikev2-vpn"
 
msg.attach(MIMEText(body, 'plain'))
 
filename = "ikev2-vpn.mobileconfig"
attachment = open("/root/ikev2-vpn.mobileconfig", "rb")
 
part = MIMEBase('application', 'octet-stream')
part.set_payload((attachment).read())
encoders.encode_base64(part)
part.add_header('Content-Disposition', "attachment; filename= %s" % filename)
 
msg.attach(part)
 
server = smtplib.SMTP('smtp.gmail.com', 587)
server.starttls()
server.login(fromaddr, "gg!@#qwe")
text = msg.as_string()
server.sendmail(fromaddr, toaddr, text)
server.quit()