# MatrixHandler

**Author:** Rickybell(Henrique Bock Belloube)

# Challenge Objective:
This project is the result of a challenge.

# Project Structure:
Originally it was to be programmed in *Go*, but as the author is not familiar with the *Go* language it was developed in Ruby on Rails.

The only *gem* added besides the original Ruby on Rails project was the Rspec for including the tests.

# Project's goal:
The project creates a **webservice**, which has only one **echo** endpoint.
```
localhost:8080/echo
```

The project should run like the Ruby on Rails way:
```
bundle exec rails server
```

And through the command line it can be run like this:
```
curl -F 'file=@/path/matrix.csv' "localhost:8080/echo"
```

As a result, the **matrix** sent must be presented in the following formats:

1. Echo (given)
    - Return the matrix as a string in matrix format.
    
    ```
    // Expected output
    1,2,3
    4,5,6
    7,8,9
    ``` 
2. Invert
    - Return the matrix as a string in matrix format where the columns and rows are inverted
    ```
    // Expected output
    1,4,7
    2,5,8
    3,6,9
    ``` 
3. Flatten
    - Return the matrix as a 1 line string, with values separated by commas.
    ```
    // Expected output
    1,2,3,4,5,6,7,8,9
    ``` 
4. Sum
    - Return the sum of the integers in the matrix
    ```
    // Expected output
    45
    ``` 
5. Multiply
    - Return the product of the integers in the matrix
    ```
    // Expected output
    362880
    ``` 

 
