import sys
import inspect
import nbformat
from IPython.lib.kernel import get_connection_file
from jupyter_client import BlockingKernelClient

def logical_xor(a, b): return bool(a) ^ bool(b)

def run_cell(notebook_path, cell_number=None, cell_tag=None):
    assert logical_xor((True if cell_number is not None else False),
                       cell_tag), "Must provide cell_number xor cell_tag"

    # Read notebook
    notebook_file = open(notebook_path)
    nb = nbformat.read(notebook_file, as_version=4)

    # Code cells
    nb_code_cells = [c for c in nb.cells if c["cell_type"] == "code"]
    cell_source = None

    if cell_tag:

        for cell in nb_code_cells:
            if "tags" in cell.metadata:
                if cell_tag in cell.metadata.tags:
                    cell_source = cell.source
                    break
        else:
            assert cell_source, "Unable to find cell with tag %s" % cell_tag

    elif cell_number is not None:

        assert cell_number in range(
            len(nb_code_cells)), "cell_number outside of range"
        cell_source = nb_code_cells[cell_number].source

    assert cell_source, "Unable to get cell source"

    # Creat kernel client on current
    # running kernal
    client = BlockingKernelClient()
    client.load_connection_file(get_connection_file())
    client.start_channels()

    # Execute code cell
    client.execute(cell_source)
    del client


def run_cells(notebook_path, cell_numbers=None, cell_tags=None):
    assert logical_xor(
        cell_numbers, cell_tags), "Must provide cell_numbers xor cell_tags"

    if cell_numbers:
        for cell_number in cell_numbers:
            run_cell(notebook_path, cell_number=cell_number)
    elif cell_tags:
        for cell_tag in cell_tags:
            run_cell(notebook_path, cell_tag=cell_tag)
