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
			w !,"ID",?$X+10,"Title",?$X+10,"Author",?$X+10,"Genre",?$X+10,"Friend"
			w !,id,?$X+10,book.Title,?$X+10,book.Author,?$X+10,book.Genre,?$X+10,book.Friend.Name
			
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
					w !,"ID",?$X+10,"Title",?$X+10,"Author",?$X+10,"Genre",?$X+10,"Friend"
				}
				set book = ##class(Library.Book).%OpenId(i)
				w !,i,?$X+10,book.Title,?$X+10,book.Author,?$X+10,book.Genre,?$X+10,book.Friend.Name
			}
			set i = i + 1
		} while (status = 1)
		return status
	}
	
	
	ClassMethod LoanBook(idBook As %Integer, idFriend As %String) As %Status
	{
		
		set status = ##class(Library.Book).%ExistsId(idBook)
		if status = 1{
			set book = ##class(Library.Book).%OpenId(idBook)
			set statusFriend = ##class(Library.Person).%ExistsId(idFriend)
			if statusFriend = 1{
				set friend = ##class(Library.Person).%OpenId(idFriend)
				set book.Friend = friend
				w !,"Book: "_book.Title_" loaned to: "_book.Friend.Name
				set result = book.%Save()
			}
		}
		return result
		
	}
	
		ClassMethod ReturnBook(idBook As %Integer) As %Status
	{
		
		set status = ##class(Library.Book).%ExistsId(idBook)
		if status = 1{
			set book = ##class(Library.Book).%OpenId(idBook)
			set book.Friend = ""
			w !,"Book: "_book.Title_" has been returned!"
			set result = book.%Save()
			return result
		}
		return status
	}
	
	
	Query BooksLoaned() As %SQLQuery
	{
		SELECT * 
		FROM Library.Book
		WHERE Friend IS NOT NULL
	}
	
	
	ClassMethod GetLoanedBooks() As %ArrayOfObjects
	{
		set booksRS = ##class(%ResultSet).%New("Library.Book,BooksLoaned")
		set rsStatus = booksRS.Execute()
		set i = 1
		set books = ""
		if rsStatus = $$$OK {
			while booksRS.Next() {
				set book = ##class(Library.Book).%New()
				set book.Title = booksRS.Get("Title")
				set book.Author = booksRS.Get("Author")
				set book.Genre = booksRS.Get("Genre")
				set dbFriend = ##class(Library.Person).%OpenId(booksRS.Get("Friend"))
				set book.Friend = dbFriend
				set books(i) = book
				set i = i + 1
			}
		}else{
			w !,"Error fetching books in GetoanedBooks()"
		}
		do booksRS.Close()
		return books
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