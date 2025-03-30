using namespace System.Windows.Forms
using namespace System.Drawing

# Assume file called 'image.png' in the users 'Pictures' folder
$Title = "Display image with PowerShell example"
$ImageFileName = "image.png"

$PicturesPath = Join-Path -Path $env:USERPROFILE -ChildPath Pictures
$ImagePath = Join-Path -Path $PicturesPath -ChildPath $ImageFileName
$ImageFileInfo = Get-Item -Path $ImagePath
$Image = [Image]::FromFile($ImageFileInfo)

$PictureBox = [PictureBox]::new()
$PictureBox.Size = $Image.Size
$PictureBox.Image = $Image

$Form = [Form]::new()
$Form.Text = $Title
$Form.Size = $Image.Size
$Form.Controls.Add($PictureBox)
$Form.ShowDialog()