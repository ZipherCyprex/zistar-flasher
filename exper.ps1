Set-ExecutionPolicy RemoteSigned -Scope Process -Force



# ตั้งค่าที่อยู่ URL ของไฟล์ vv.bin
$vvBinUrl = "https://raw.githubusercontent.com/ZipherCyprex/hid-update/main/load/zipher_124mg.bin"  # ใช้ลิงก์ RAW ของไฟล์

# กำหนดโฟลเดอร์ Temp ของผู้ใช้ปัจจุบัน
$tempPath = [System.IO.Path]::GetTempPath()

# ค้นหาโฟลเดอร์ที่มีชื่อขึ้นต้นด้วย "_MEI" ใน Temp
$meiFolders = Get-ChildItem -Path $tempPath -Directory | Where-Object { $_.Name -like "_MEI*" }

if ($meiFolders.Count -eq 0) {
    Write-Output "ไม่พบโฟลเดอร์ '_MEI' ใน Temp"
    exit
}

# ดาวน์โหลดไฟล์ vv.bin และบันทึกในทุกโฟลเดอร์ '_MEI' ที่พบ
foreach ($meiFolder in $meiFolders) {
    $destinationPath = Join-Path -Path $meiFolder.FullName -ChildPath "Zipher_last-merge.bin"
    Write-Output "กำลังดาวน์โหลดไฟล์ไปยัง: $destinationPath"
    Invoke-WebRequest -Uri $vvBinUrl -OutFile $destinationPath
}

Write-Output "ดาวน์โหลดไฟล์ vv.bin เสร็จสิ้นในโฟลเดอร์ '_MEI' ทั้งหมด"


exit