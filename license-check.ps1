$sqlite_path = "C:\Program Files\Path to Sqlite Database"
$hostname = hostname

# SMTP Server parametreleri
$from_mail = "Lisans-Bilgilendirme <$hostname@company.com.tr>"
$to_mail = "Ekip Yonetimi <EkipYonetimi@company.com.tr>", "Ekip Yonetimi2 <EkipYonetimi2@company.com.tr>"
$mail_subject = "Application License Check"
$smtp_server = "smtp.company.com"


cd $sqlite_path

$remaining_unrestricted_days = D:\Path-to-Sqlite-Binary\sqlite3.exe .\Sqlite-Database-Name.sqlite "select remaining_unrestricted_days from licenses_info;" ".exit" | Out-String
$remaining_unrestricted_date = (Get-date).AddDays($remaining_unrestricted_days).ToString("dd-MM-yyyy")


if ([int] $remaining_unrestricted_days -lt 61 )
{
    Send-MailMessage -From $from_mail -To $to_mail -Subject $mail_subject -Body "Merhaba,`n`n$hostname sunucusundaki uygulama lisansinin expire olma zamani kontrol edildi.`n`nExpire olma tarihi: $remaining_unrestricted_date (gun-ay-yil)`n`nKalan gun sayisi: $remaining_unrestricted_days `nIyi calismalar`nEkip Yonetimi" -Priority High -SmtpServer $smtp_server
}
else
{
    Write-Host "Expire olma tarihi: $remaining_unrestricted_date (gun-ay-yil)`nKalan gun sayisi: $remaining_unrestricted_days"
}
