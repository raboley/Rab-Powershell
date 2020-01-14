# Ensure there is no issues with two editions of the module and testing
If (Get-Module Rab-Powershell) {
    Write-Verbose 'Found existing version of the Rab-Powershell module loaded, removing it...'
    Remove-Module -Name Rab-Powershell
}

Describe "Compare-rabHashtable" {
    It 'loads without errors' {
        Set-Location ..
        Import-Module -Name ../Rab-Powershell
        Get-Module Rab-Powershell | Should -Not -BeNullOrEmpty
    }

    It "Returns true when two hash tables are the same" {
        $expected = @{ name = 'steve' }
        $actual = @{ name = 'steve' }

        Compare-rabHashtable $actual $expected | Should -Be $true
    }

    It "Returns false when two hash tables have the same keys with different values" {
        $expected = @{ name = 'steve' }
        $actual = @{ name = 'jim' }

        Compare-rabHashtable $actual $expected | Should -Be $false
    }

    It "Returns false when two hash tables have the same keys with different values" {
        $expected = @{ name = 'steve' }
        $actual = @{ FirstName = 'jim' }

        Compare-rabHashtable $actual $expected | Should -Be $false
    }

    It "Returns true when there are two hashtables with the same structure" {
        $expected = @{ name = 'steve'; pets = @{ dog = 'sparky'; cat = 'jim'} } | ConvertTo-Json
        $actual = @{ name = 'steve'; pets = @{ dog = 'sparky'; cat = 'jim'} } | ConvertTo-Json

        $actual | Should -Be $expected
    }

    It "Returns true when there are two hashtables with the same structure" {
        $expected = @{ name = 'steve'; pets = @{ dog = 'sparky'; cat = 'jim'} } | ConvertTo-Json
        $actual = @{ name = 'steve'; pets = @{ cat = 'jim'; dog = 'sparky' } } | ConvertTo-Json

        $actual | Should -Be $expected
    }
}