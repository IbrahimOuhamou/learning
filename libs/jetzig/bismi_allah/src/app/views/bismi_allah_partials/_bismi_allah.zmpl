@args bismi_allah_object: *ZmplValue
<div>
    <p>basmala: <b>{{ zmpl.coerceString(bismi_allah_object.get("basmala")) catch "alhamdo li Allah: internal error while getting 'basmala'" }}</b></p>
    <p>hamd: <b>{{ zmpl.coerceString(bismi_allah_object.get("hamd")) catch "alhamdo li Allah: internal error while getting 'hamd'" }}</b></p>
</div>
