
function declare_arrays() {
    delete varname_to_lineno_map;
    delete lineno_to_varname_map;
    delete matching_linenos;

    delete found;
    
    delete result
    delete object_key_indexes;
    delete object_int_indexes;
    
    delete object_key_types;
    delete object_value_types;
    
    delete object_keys;
    delete object_values;
    delete object_items;
    
    delete result["object_keys"]
    delete result["object_values"]
    delete result["object_items"]
    delete item;
    
    delete varname_to_lineno_map;
    delete lineno_to_varname_map;
    delete matching_linenos;
}

BEGIN {
    declare_arrays()
    regexp_troff="^\s*([.](SS\s+Shell\s+Variables|B\s+([A-Z_]+[A-Z0-9_]*))"
}
function debug_thing(object) {
    object_ty=type_of(object);
    

    result["object_value"]=object;
    result["object_ty"]=object_ty;

    
    object_len=-1;
    if ((object_ty == "array") || object_ty == "string") {
        object_len=length(object)
        result["object_len"]=object_ty;
    }
    delete result
    delete object_key_indexes;
    delete object_int_indexes;
    
    delete object_key_types;
    delete object_value_types;
    
    delete object_keys;
    delete object_values;
    delete object_items;
    
    delete result["object_keys"]
    delete result["object_values"]
    delete result["object_items"]
    delete item;

    
    if (object_ty == "array") {
        o_key_idx=0;
        o_int_idx=0;
        iter_idx=-1;
        for (key in object) {
            iter_idx++;
            o_key_idx=iter_idx;
            o_int_idx=iter_idx;
            
            value_ty=type_of(key)
            object_key_types[iter_idx]=value_ty

            value=object[key]
            value_ty=type_of(value)
            object_value_types[iter_idx]=value

            result["key", key]=key_ty
            result["value", value]=value_ty
            
            result["key", key]=key_ty
            result["value", value]=value_ty

            result["object_key", key]=key
            result["object_key", key]=key
            result["object_value", key]=value

            object_key_types[iter_idx]=key_ty;
            object_value_types[iter_idx]=value_ty;
    
            object_keys[iter_idx]=key
            object_values[iter_idx]=value
            object_items[iter_idx]=item
    
            delete result["object_keys"]
            delete result["object_values"]
            delete result["object_items"]

            
            if (iter_idx == key){ # int
                object_int_indexes[o_int_idx]=key;
            } else {
                object_key_indexes[o_key_idx]=key;
            }
        }
        
    }
}
{
    delete found;
    haystack=$0;
    
    where=match(haystack, regexp_troff, found);
    varname=gensub(regexp_troff, "\2", "g", haystack)
    varname=gensub(regexp_troff, "\2", "g", haystack)

}
2132:.B BASH_XTRACEFD
2140:.B BASH_XTRACEFD
2144:.B BASH_XTRACEFD
2149:.B BASH_XTRACEFD


# ^\s*([.](SS\s+Shell\s+Variables|B\s+([A-Z_]+[A-Z0-9_]*))
