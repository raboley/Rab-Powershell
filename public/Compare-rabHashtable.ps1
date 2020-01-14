function Compare-rabHashTable {
    param (
        $left,
        $right
    )
    foreach ($key in $left.Keys) {
        if (Test-rabIsHashtable $left[$key]){
            Compare-rabHashTable $left[$key] $right[$key]
        } elseif ($left[$key] -ne $right[$key]){
            #$left[$key] | Should -Be $right[$key]
            return $false
        }
    }
    return $true
}