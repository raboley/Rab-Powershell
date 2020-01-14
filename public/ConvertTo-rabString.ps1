function ConvertTo-rabString {
    param (
        $object
    )
    $begin = '@{ '
    $body = Write-Body $object
    $end = ' }'
    return $begin + $body + $end
}

function Write-Body {
    param (
        $object
    )
    $body = ''
    $i = 0
    foreach($key in $object.Keys){
        if($i -gt 0){
            $body += '; '
        }
        
        $body += Get-KeyName $key
        if(Test-rabIsHashtable $object[$key]){
            $body += ConvertTo-rabString $object[$key]
        } else{
            $body += "'" + $object[$key] + "'"
        }
        $i++
    }
    
    return $body
}

function Get-KeyName ($key) {
    if( $key -like '*-*'){
        return "'$($key)' = "
    }
    return "$($key) = "
}
