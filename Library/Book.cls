Class Library.Book Extends %Persistent
{
	Property Title As %String [Required];
	Property Author As %String [Required];
	Property Genre As %String;
	Property Friend As Library.Person;
	
	
	ClassMethod AddBook(title As %String, author As %String, genre As %String = "No genre" ) As %Status
	{
		
		set book = ##class(Library.Book).%New()
		set book.Title = title
		set book.Author = author
		set book.Genre = genre 
		set status = book.%Save()
		return status
	}
	
Storage Default
{
<Data name="BookDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Title</Value>
</Value>
<Value name="3">
<Value>Author</Value>
</Value>
<Value name="4">
<Value>Genre</Value>
</Value>
<Value name="5">
<Value>Friend</Value>
</Value>
</Data>
<DataLocation>^Library.BookD</DataLocation>
<DefaultData>BookDefaultData</DefaultData>
<IdLocation>^Library.BookD</IdLocation>
<IndexLocation>^Library.BookI</IndexLocation>
<StreamLocation>^Library.BookS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}