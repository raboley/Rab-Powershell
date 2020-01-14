# Ensure there is no issues with two editions of the module and testing
If (Get-Module Rab-Powershell) {
    Write-Verbose 'Found existing version of the Rab-Powershell module loaded, removing it...'
    Remove-Module -Name Rab-Powershell
}

Describe "Test-rabIsHashtable" {
    It 'loads without errors' {
        Set-Location ..
        Import-Module -Name ../Rab-Powershell
        Get-Module Rab-Powershell | Should -Not -BeNullOrEmpty
    }

    It "Should return true when the object is a hastable" {
        $hashtable = @{ name="positive tests"}
        $actual = Test-rabIsHashtable -object $hashtable

        $actual | Should -Be $true
    }

    It "Should return false when the object is a string" {
        $object = "negative tests"
        $actual = Test-rabIsHashtable -object $object

        $actual | Should -Be $false
    }

    It "Should return false when the object is an array" {
        $object = @("negative tests", "other values")
        $actual = Test-rabIsHashtable -object $object

        $actual | Should -Be $false
    }
}