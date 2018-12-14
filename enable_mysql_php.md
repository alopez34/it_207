# Install and Enable Mysql php Module

## Environment Configuration
- php 5.6.5.9-1ubuntu 4.6 cli (built: Feb 13 2015)
- Apache 2.4.7 (built: Jul 22 2014)

## Install Procedures

- apt-get udpate
- apt-get install php5-mysql
- php5enmod mysql

### MYSQL config
___
#### User: Admin

#### Password: Admin2015
___
Sample PHP code:

```//create connectin with localhost database
$connection = mysqli_connect("localhost", "root", "Admin2015", "exampleDB");

//get resultset
$result = mysqli_query($connection, "SELECT * FROM dog");

while($record = mysqli_fetch_array($result)){
    echo "<p> $record[0] </p>";
}
```
