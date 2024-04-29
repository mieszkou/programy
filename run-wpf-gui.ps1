Add-Type -AssemblyName PresentationFramework

[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    x:Name="Window" Height="210" VerticalAlignment="Top">
    <Grid x:Name="Grid" Height="95" Width="326" VerticalAlignment="Top">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="Auto" MinWidth="119"/>
            <ColumnDefinition Width="Auto" MinWidth="77.01"/>
        </Grid.ColumnDefinitions>
        <TextBox x:Name = "PathTextBox"
            Grid.Column="0"
            Grid.Row="1" Margin="12,12,10,-6"
        />
        <Button x:Name = "ValidateButton"
            Content="Validate"
            Grid.Column="1"
            Grid.Row="1" Margin="35,10,-103,-27"
        />
        <Button x:Name = "RemoveButton"
            Content="Remove"
            Grid.Column="0"
            Grid.Row="1" Grid.ColumnSpan="2" Margin="20,107,-66,-117"
        />
    </Grid>
</Window>
"@
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)
$validateButton = $window.FindName("ValidateButton")
$removeButton = $window.FindName("RemoveButton")
$pathTextBox = $window.FindName("PathTextBox")
$ValidateButton.Add_Click({
    If(-not (Test-Path $pathTextBox.Text)){
        $pathTextBox.Text = ""
    }
})
$removeButton.Add_Click({
    If($pathTextBox.Text){
        If(Test-Path $pathTextBox.Text){
            Remove-Item $pathTextBox.Text
        }
    }
})
$window.ShowDialog()