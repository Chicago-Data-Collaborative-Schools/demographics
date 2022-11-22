import sys

import pandas

df = pandas.read_csv(sys.stdin)

pandas.melt(
    df,
    id_vars=["year", "School ID", "School"],
    var_name="grade",
    value_name="students",
    ignore_index=True,
).to_csv(sys.stdout, index=False)
