<!-- بسم الله الرحمن الرحيم -->
<!-- la ilaha illa Allah Mohammed Rassoul Allah -->


<script>
    // NOTE FROM THE DOCS:
    // Most of the time, you shouldn’t. $effect is best thought of as an escape
    // hatch, rather than something to use frequently. If you can put your side
    // effects in an event handler, for example, that’s almost always preferable.
    
    let elapsed = $state(0);
    let interval = $state(1000);

    $effect(() => {
        const id = setInterval(() => {
            elapsed += 1;
        }, interval);

        return () => {
            clearInterval(id);
        };
    });
</script>

<div>
    <button class="p-1 bg-indigo-300 text-md rounded-sm" onclick={() => interval /= 2}>
        speed up
    </button>
    <button class="p-1 bg-indigo-300 text-md rounded-sm" onclick={() => interval *= 2}>
        slow down
    </button>

    <p>{elapsed}</p>
</div>

