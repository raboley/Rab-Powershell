# Ensure there is no issues with two editions of the module and testing
If (Get-Module Rab-Powershell) {
    Write-Verbose 'Found existing version of the Rab-Powershell module loaded, removing it...'
    Remove-Module -Name Rab-Powershell
}

    
Describe "ConvertTo-rabString" {
    
    It 'loads without errors' {
        Set-Location ..
        Import-Module -Name ../Rab-Powershell
        Get-Module Rab-Powershell | Should -Not -BeNullOrEmpty
    }

    InModuleScope Rab-Powershell {  
        It "Should convert one hash table successfully" {
            $expected = "@{ name = 'Hello' }"
        
            $hash = @{ name = 'Hello' }
            $actual = ConvertTo-rabString $hash

            $actual | Should -Be $expected
        }

        It "Should quote strings that have a '-' in them" {
            $expected = "@{ 'name-space' = 'Hello' }"
        
            $hash = @{ 'name-space' = 'Hello' }
            $actual = ConvertTo-rabString $hash

            $actual | Should -Be $expected
        }

        It "Should convert one hash table successfully" {
            $expected = "@{ name = 'Hello' }"
        
            $hash = @{ name = 'Hello' }
            $actual = ConvertTo-rabString $hash

            $actual | Should -Be $expected
        }

        It "Should convert one hash table with two properties successfully" {
            $expected = "@{ name = 'Hello'; type = 'string' }"
        
            $hash = [ordered]@{ name = 'Hello'; type = 'string' }
            $actual = ConvertTo-rabString $hash

            $actual | Should -Be $expected
        }

        It "Should convert a hash table with a hash table in it" {
            $expected = "@{ InnerTable = @{ name = 'hello' } }"
        
            $hash = @{ InnerTable = @{ name = 'Hello' } }
            $actual = ConvertTo-rabString $hash

            $actual | Should -Be $expected
        }

        It "Should convert a hash table with a hash table in it with two properties" {
            $expected = "@{ InnerTable = @{ name = 'hello'; type = 'string' } }"
        
            $hash = [ordered]@{ InnerTable = [ordered]@{ name = 'Hello'; type = 'string' } }
            $actual = ConvertTo-rabString $hash

            $actual | Should -Be $expected
        }

        It "Should convert a hash table with two hash tables in it with two properties" {
            $expected = "@{ InnerTable = @{ name = 'hello'; type = 'string' }; SecondInnerTable = @{ name = 'second'; type = 'int' } }"
        
            $hash = [ordered]@{ InnerTable = [ordered]@{ name = 'Hello'; type = 'string' }; SecondInnerTable = [ordered]@{ name = 'second'; type = 'int' } }
            $actual = ConvertTo-rabString $hash

            $actual | Should -Be $expected
        }
    }
}
