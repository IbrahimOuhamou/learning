// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah

/** @type {import('./$types').PageLoad} */
export async function load() {
	const res = await fetch('/bismi_allah.json');
	// const res = await fetch('https://dummyjson.com/quotes');
	const data = await res.json();

	return { json };

    // return { 
    //     quotes: [
    //         {
    //             quote: "la ilaha illa Allah",
    //             author: "Truth",
    //         },
    //         {
    //             quote: "Mohammed Rassoul Allah",
    //             author: "Truth",
    //         },
    //         {
    //             quote: "Allah akbar",
    //             author: "Truth",
    //         },
    //     ]
    // };
}
