for (let i = 1; i <= 100; ++i) {
	if (i % 3 == 0){
        process.stdout.write("Fizz");
    }
    if (i % 5 == 0){
        process.stdout.write("Buzz");
    }
    if (i % 3 != 0 && i % 5 != 0){
        process.stdout.write(""+i);
    }
    process.stdout.write("\n");
}
