Class Library.Person Extends %Persistent
{
	Property Name As %String [Required];
	Property PhoneNumber As %Integer;
	
	
	ClassMethod AddFriend(name As %String, phoneNumber As %Integer) As %Status
	{
		
		set friend = ##class(Library.Person).%New()
		set friend.Name = name
		set friend.PhoneNumber = phoneNumber
		set status = friend.%Save()
		return status
	}
	
Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>PhoneNumber</Value>
</Value>
</Data>
<DataLocation>^Library.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^Library.PersonD</IdLocation>
<IndexLocation>^Library.PersonI</IndexLocation>
<StreamLocation>^Library.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}