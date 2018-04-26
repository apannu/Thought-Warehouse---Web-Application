$(function () {
    window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;


    //prefixes of window.IDB objects
    window.IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction;
    window.IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange;

    if (!window.indexedDB) {
        window.alert("Your browser doesn't support a stable version of IndexedDB.")
    }
    else {
        var openRequest = indexedDB.open("todolist", 1);

        openRequest.onupgradeneeded = function (e) {
            console.log("Upgrading...");
            var thisDB = e.target.result;

            if (!thisDB.objectStoreNames.contains("noteDatabase")) {
                thisDB.createObjectStore("noteDatabase", {autoIncrement: true, keyPath: "id"});
                console.log("noteDatabase upgraded!");
            }
        }

        openRequest.onsuccess = function (e) {
            var db;
            console.log("Success!");
            db = e.target.result;
            displayAllnotes(db);

            $("#addNote").click(function () {
                addNote(db);
                displayAllnotes(db);
            });
        }

        openRequest.onerror = function (e) {
            console.log("Error");
            console.dir(e);
        }
    }
});

function addNote(db) {
	

    var note = $("#noteSubject").val();

    var authorName = $("#authorName").val();

    var noteDescription = $("#noteContent").val();

    var total = $("#noteContent").val().length;
    
    if(authorName.length==0 || noteDescription.length==0 || note.length==0)
    {
    	alert("Please enter value in the all three below fields");
    }
    else
    {
	    noteDescription = noteDescription
	        .replace(/</g, "&lt;")
	        .replace(/>/g, "&gt;")
	        .replace(/&/g,"&amp;")
	        .replace(/"/g,"&quot;")
	        .replace(/'/g,"&#039;");
	
	    authorName = authorName
	        .replace(/</g, "&lt;")
	        .replace(/>/g, "&gt;")
	        .replace(/&/g,"&amp;")
	        .replace(/"/g,"&quot;")
	        .replace(/'/g,"&#039;");
	
	
	    note = note
	        .replace(/</g, "&lt;")
	        .replace(/>/g, "&gt;")
	        .replace(/&/g,"&amp;")
	        .replace(/"/g,"&quot;")
	        .replace(/'/g,"&#039;");
	
	    var transaction = db.transaction(["noteDatabase"], "readwrite");
	    var store = transaction.objectStore("noteDatabase");
	    console.log(total);
	    var noteDetails = {
	        id: total,
	        authorName: authorName,
	        noteSubject: note,
	        noteDescription: noteDescription,
	        createdAt: getDate(),
	        total: total
	        
	    }
	
	    console.log(noteDetails);
	
	    var request = store.add(noteDetails);
	
	    request.onerror = function (e) {
	        console.log("Error", e.target.error.name);
	    }
	
	    request.onsuccess = function (e) {
	        console.log("Note has been added.");
	    }
	
	    var resultsWrapper = document.getElementById('toDoList');
	
	    resultsWrapper.innerHTML = "";
	    alert("Note has been added.");
    }
}

function getDate() {
    var date = new Date();
    var datestring = ("0" + date.getDate()).slice(-2) + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" +
        date.getFullYear() + " " + ("0" + date.getHours()).slice(-2) + ":" + ("0" + date.getMinutes()).slice(-2);

    return datestring;
}

function displayAllnotes(db) {

    var count = 1;
    var notesCount = 0;
    var transaction = db.transaction(["noteDatabase"], "readonly");
    var store = transaction.objectStore("noteDatabase");
    var request = store.openCursor();
    
    var cursor;
    request.onsuccess = function (event) {
        cursor = event.target.result;

        var resultsWrapper = document.getElementById('toDoList');
        document.getElementById('addNote').style.marginBottom = "10px";
        if (cursor) {
        	
        	//main div
        	var h4NoteCount = document.createElement("h2");
        	h4NoteCount.innerHTML = "Note "+count;
        	
        	var h4Information = document.createElement("h3");
        	h4Information.innerHTML = "*Please click on Show Details to view, Edit Note to edit, and Delete icon to delete a note";
        	
        	 var a = document.createElement('a');
             a.setAttribute('id', 'fshowDetails'+count);
             a.setAttribute('href',"#");
             a.innerHTML = "Show Details";
             a.style.fontSize = "1.1em";
             a.setAttribute("onClick", 'showDetails("' + count + '")');
             
             var a1 = document.createElement('a');
             a1.setAttribute('id', 'shideDetails'+count);
             a1.setAttribute('href',"#");
             a1.innerHTML = "Hide Details";
             a1.style.fontSize = "1.1em";
             a1.setAttribute("onClick", 'hideDetails("' + count + '")');
             a1.style.display = "none";
             
            var divNote = document.createElement('div');
            divNote.id = cursor.key;
            divNote.style.marginBottom = "10px";
            divNote.style.marginTop = "20px";
            divNote.style.border = "1px solid";
            divNote.style.borderColor = "silver";
            divNote.className = "row col s12";
            
            //first div
            var firstDiv = document.createElement('div');
            firstDiv.setAttribute("id", "fdiv"+count);
            firstDiv.className = "divBottomBorder";
            firstDiv.style.marginBottom = "10px";
            
            var h4NoteSubject = document.createElement("h4");
            h4NoteSubject.innerHTML = "Note Subject:";
            h4NoteSubject.style.paddingLeft = "0.4cm";

            var noteSubjectInputText = document.createElement('input');
            noteSubjectInputText.setAttribute("value", cursor.value.noteSubject);
            noteSubjectInputText.setAttribute("id", "noteSubjectInputText"+count);
            noteSubjectInputText.disabled = false;
            
            firstDiv.appendChild(h4NoteSubject);
            firstDiv.appendChild(noteSubjectInputText);
            
            divNote.appendChild(firstDiv);
            
            //second div
            var secondDiv = document.createElement('div');
            secondDiv.setAttribute("id", "sdiv"+count);
            secondDiv.className = "divBottomBorder";
//            secondDiv.style.marginBottom = "10px";
            
            var h4Date = document.createElement("h4");
            h4Date.innerHTML = "Created Date:";
            h4Date.style.paddingLeft = "0.4cm";

            var dateInputText = document.createElement('input');
            dateInputText.setAttribute("value", cursor.value.createdAt);
            dateInputText.setAttribute("id", "dateInputText"+count);
            dateInputText.disabled = true;
            
            secondDiv.appendChild(h4Date);
            secondDiv.appendChild(dateInputText);

            divNote.appendChild(secondDiv);
            
            //third div
            var thirdDiv = document.createElement('div');
            thirdDiv.setAttribute("id", "tdiv"+count);
            thirdDiv.className = "divBottomBorder";
            thirdDiv.style.marginBottom = "10px";
            thirdDiv.style.display = "none";
            
            var h4AuthorName = document.createElement("h4");
            h4AuthorName.innerHTML = "Author Name:";
            h4AuthorName.style.paddingLeft = "0.4cm";
            
            var authorNameInputText = document.createElement('input');
            authorNameInputText.setAttribute("value", cursor.value.authorName);
            authorNameInputText.setAttribute("id", "authorNameInputText"+count);
            authorNameInputText.disabled = false;
//            authorNameInputText.style.width = "300px";
            
            thirdDiv.appendChild(h4AuthorName);
            thirdDiv.appendChild(authorNameInputText);
            
            divNote.appendChild(thirdDiv);
            
            //fourth div
            var fourthDiv = document.createElement('div');
            fourthDiv.setAttribute("id", "frdiv"+count);
            fourthDiv.className = "divBottomBorder";
            fourthDiv.style.marginBottom = "10px";
            fourthDiv.style.display = "none";
            
            var h4NoteContent = document.createElement("h4");
            h4NoteContent.innerHTML = "Note Content:";
            h4NoteContent.style.paddingLeft = "0.4cm";

            var noteContentTextArea = document.createElement('textarea');
            noteContentTextArea.setAttribute("rows", 3);
            noteContentTextArea.setAttribute("id", "noteContentTextArea"+count);
            noteContentTextArea.disabled = false;
            noteContentTextArea.style.width = "1183px";
            noteContentTextArea.style.paddingLeft = "14px";
            
            var textAreaContent = document.createTextNode(cursor.value.noteDescription);
            noteContentTextArea.appendChild(textAreaContent);
            
            fourthDiv.appendChild(h4NoteContent);
            fourthDiv.appendChild(noteContentTextArea);

            divNote.appendChild(fourthDiv);
            
            //fifth div
            var fifthDiv = document.createElement('div');
            fifthDiv.setAttribute("id", "ffdiv"+count);
            fifthDiv.style.display = "none";
            fifthDiv.className = "divBottomBorder";
            
            var h4Count = document.createElement("h4");
            h4Count.innerHTML = "Note Content Count:";
            h4Count.style.paddingLeft = "0.4cm";

            var countInputText = document.createElement('input');
            countInputText.setAttribute("value", cursor.value.total);
            countInputText.setAttribute("id", "countInputText"+count);
            countInputText.id = cursor.key;
            countInputText.disabled = true;
            
            fifthDiv.appendChild(h4Count);
            fifthDiv.appendChild(countInputText);

            divNote.appendChild(fifthDiv);
            
            //sixth div
            var sixthDiv = document.createElement('div');
            sixthDiv.setAttribute("id", "ffdiv"+count);
            sixthDiv.style.marginTop = "15px";
            sixthDiv.style.paddingLeft = "0.4cm";
            sixthDiv.style.marginBottom = "12px";
            sixthDiv.className = "divBottomBorder";

            var a2 = document.createElement('a');
            a2.setAttribute('id', 'updateNote'+count);
            a2.setAttribute('href',"#");
            a2.innerHTML = "Update Note";
            a2.style.fontSize = "1.1em";
            a2.setAttribute("onClick", 'updateNote("' + cursor.key + '", "' + count + '")');
            
            sixthDiv.appendChild(a2);

            divNote.appendChild(sixthDiv);
            
            var deleteDiv = document.createElement('div');
            deleteDiv.setAttribute("id", "ediv"+count);
            deleteDiv.style.marginBottom = "17px";
            deleteDiv.style.marginTop = "17px";
            
            
            var iconDelete = document.createElement("i");
            iconDelete.className = "fa fa-trash-o";
            iconDelete.title = "Delete";
            iconDelete.id = cursor.key;
            iconDelete.setAttribute('onClick', 'deleteNote("' + cursor.key + '")');
            
            deleteDiv.appendChild(iconDelete);

            //append main div
            resultsWrapper.appendChild(h4NoteCount);
            resultsWrapper.appendChild(h4Information);
            resultsWrapper.appendChild(a);
            resultsWrapper.appendChild(a1);
            resultsWrapper.appendChild(deleteDiv);
            resultsWrapper.appendChild(divNote);
            count++;
            notesCount++;
            cursor.continue();
        } else {
        }
        
        console.log("count: "+notesCount);
        document.getElementById("countLabel").textContent = "Number of notes saved: "+notesCount;
        if(notesCount==0)
        	document.getElementById("borderDiv").style.display = "none";
        else
        	document.getElementById("borderDiv").style.display = "block";
        
    	
    };
}

function updateNote(id, count)
{
	    var openRequest = indexedDB.open("todolist", 1);

        openRequest.onsuccess = function (e) {
            console.log("Success!");
            var db;
            db = e.target.result;

            var transaction = db.transaction(["noteDatabase"], "readwrite");
            var store = transaction.objectStore("noteDatabase");
            var request = store.get(+id);

            request.onsuccess = function (event) {
                var data = event.target.result;
                
                var note = $("#noteSubjectInputText"+count).val();
           	 console.log("note: "+note);

           	    var authorName = $("#authorNameInputText"+count).val();
           	    console.log("note: "+authorName);

           	    var noteDescription = $("#noteContentTextArea"+count).val();
           	    console.log("note: "+noteDescription);

           	    var total = noteDescription.length;
           	    console.log(total);

                data.noteSubject = note;
                data.noteDescription = noteDescription;
                data.authorName = authorName;
                data.createdAt = getDate();

                var requestUpdate = store.put(data);
                requestUpdate.onerror = function (event) {

                    console.log("Error", e.target.error.name);
                };
                requestUpdate.onsuccess = function (event) {
                    // Success - the data is updated!
                    alert("Note had been updated successfully");
                    var resultsWrapper = document.getElementById('toDoList');

                    resultsWrapper.innerHTML = "";

                    displayAllnotes(db);
                };
            };
        }
}
function deleteNote(id) {

    window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;
    window.IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction;
    window.IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange;
    var openRequest = indexedDB.open("todolist", 1);


    openRequest.onsuccess = function (e) {
        console.log("Success!");
        var db;
        db = e.target.result;

        var transaction = db.transaction(["noteDatabase"], "readwrite");
        var store = transaction.objectStore("noteDatabase");
        var request = store.delete(+id);

        request.onsuccess = function (event) {
            var resultsWrapper = document.getElementById('toDoList');
            alert("Note has been deleted");
            resultsWrapper.innerHTML = "";

            displayAllnotes(db);
        };

        request.onerror = function (e) {
            console.log("Error", e.target.error.name);
            //some type of error handler
        }
    }
}

function showDetails(count)
{	
	document.getElementById("tdiv"+count).style.display = "block";
	document.getElementById("frdiv"+count).style.display = "block";
	document.getElementById("ffdiv"+count).style.display = "block";
	document.getElementById("fshowDetails"+count).style.display = "none";
	document.getElementById("shideDetails"+count).style.display = "block";
	document.getElementById("sdiv"+count).style.marginBottom = "10px";
}
function hideDetails(count)
{	
	document.getElementById("tdiv"+count).style.display = "none";
	document.getElementById("frdiv"+count).style.display = "none";
	document.getElementById("ffdiv"+count).style.display = "none";
	document.getElementById("fshowDetails"+count).style.display = "block";
	document.getElementById("shideDetails"+count).style.display = "none";
	document.getElementById("sdiv"+count).style.marginBottom = "0px";
}