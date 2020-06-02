defmodule ReadmeGenerator.BuilderMD do

  def get_template_content() do
    file_path = Application.app_dir(:readme_generator, "priv/readme.md")
    {:ok, content} = File.read(file_path)
    content
  end

  def build_md_content(template, params) do
    EEx.eval_string(template, params)
  end

  def write_md_file(md_content) do
    {:ok, file} = File.open("readme_#{:os.system_time(:millisecond)}.md", [:write])
    IO.binwrite(file, md_content)
    :ok = File.close(file)
    :created
  end

  def create_readme(params) do
    template = get_template_content()
    content = EEx.eval_string(template, params)
    write_md_file(content)
  end
end
