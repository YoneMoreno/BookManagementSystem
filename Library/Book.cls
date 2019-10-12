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
	
	
	ClassMethod PrintOne(id As %Integer) As %Status
	{
		set status = ##class(Library.Book).%ExistsId(id)
		if status = 1{
			set book = ##class(Library.Book).%OpenId(id)
			w !,"Title",?$X+20,"Author",?$X+20,"Genre"
			w !,book.Title,?$X+20,book.Author,?$X+20,book.Genre
			
		}else{
			w !,"Error, there is not a book with id: "_id
		}
		return status
	}
	
	ClassMethod PrintAll() As %Status
	{
		set i = 1
		set status = 0
		do {
			set status = ##class(Library.Book).%ExistsId(i)
			if status = 1{
				if i = 1 {
					w !,"Title",?$X+20,"Author",?$X+20,"Genre"
				}
				set book = ##class(Library.Book).%OpenId(i)
				w !,book.Title,?$X+20,book.Author,?$X+20,book.Genre
			}
			set i = i + 1
		} while (status = 1)
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