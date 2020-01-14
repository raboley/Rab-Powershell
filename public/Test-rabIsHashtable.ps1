function Test-rabIsHashtable {
    param (
        $object
    )
    if($object.GetType().fullname.ToString() -eq "System.Collections.Hashtable" ){
        return $true
    }
    if($object.GetType().fullname.ToString() -eq "System.Collections.Specialized.OrderedDictionary" ){
        return $true
    }

    return $false
}
