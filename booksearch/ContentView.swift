import SwiftUI

struct ContentView: View {
    @StateObject private var favoriteManager = FavoriteManager()
    @State private var searchQuery = ""
    @State private var books: [Book] = []   found from search
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search for books", text: $searchQuery)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: searchBooks) {
                        Text("Search")
                    }
                    .padding()
                }

                if isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                List(books) { book in
                    HStack {
                        AsyncImage(url: URL(string: book.coverImageURL)) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 75)

                        VStack(alignment: .leading) {
                            Text(book.title)
                                .font(.headline)
                            Text(book.authors.joined(separator: ", "))
                                .font(.subheadline)
                            Text(book.publisher)
                                .font(.subheadline)
                        }

                        // Favorite Button
                        Button(action: {
                            toggleFavorite(book: book)
                        }) {
                            Image(systemName: favoriteManager.isFavorite(book: book) ? "heart.fill" : "heart")
                                .foregroundColor(favoriteManager.isFavorite(book: book) ? .red : .gray)
                        }
                    }
                }
            }
            .navigationTitle("Book Search")
        }
    }

    // Search Books
    private func searchBooks() {
        guard !searchQuery.isEmpty else { return }

        isLoading = true
        errorMessage = nil
        books = []

        // Simulate a delay (like a network call)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let mockBooks = [
                Book(id: "1", title: "Swift Programming", authors: ["John Doe"], publisher: "SwiftPress", coverImageURL: "https://example.com/cover1.jpg", description: nil),
                Book(id: "2", title: "Advanced Swift", authors: ["Jane Smith"], publisher: "CodeWorks", coverImageURL: "https://example.com/cover2.jpg", description: nil)
            ]
            
            // Update books list and stop loading
            self.books = mockBooks
            self.isLoading = false
        }
    }


    private func toggleFavorite(book: Book) {
        if favoriteManager.isFavorite(book: book) {
            favoriteManager.removeFavorite(book: book)
        } else {
            favoriteManager.addFavorite(book: book)
        }
    }
}

// Preview for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
