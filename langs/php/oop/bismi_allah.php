<?php
//in the name of Allah
declare(strict_types=1);

echo "in the name of Allah\n";

class bismi_allah_t
{
    public int $id;
    public string $description = "no descripition available";
    //public $untyped;

    public function __construct(int $id, string $decription = null, public $untyped = null)
    {
        $this->id = $id;
        if(!is_null($decription))
        {
            $this->description = $description;
        }
        if(!is_null($untyped))
        {
            $this->untyped = $untyped;
        }
    }

    public function show_info(): bismi_allah_t
    {
        echo 'type: ' . gettype($this) . "\n";
        echo 'id: ' . $this->id . "\n";
        echo 'description: ' . $this->description . "\n";
        echo 'untyped: ' . $this->untyped . "\n";

        return $this;
    }

    public function __destruct()
    {
        echo "========================================== will destruct =====================================\n";
        $this->show_info();
        echo "==============================================================================================\n";
    }
}

$bismi_allah = new bismi_allah_t(12);


unset($bismi_allah);
$bismi_allah = null;
//$bismi_allah->show_info();

?>
