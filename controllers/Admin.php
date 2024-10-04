<?php
use MX\MX_Controller;
class admin extends MX_Controller
{
    public function __construct()
    {
        $this->load->library('administrator');
        $this->load->model("data_model");
       
    }
    public function index()
    {
        $data = array(
            'url'     => $this->template->page_url,
            "configs" => $this->data_model->getconfig(),
            "this"    => $this
        );
        $output = $this->template->loadPage("admin.tpl", $data);
        $content = $this->administrator->box('Services', $output);
        $this->administrator->view($content,  false, "modules/character_tools/js/admin.js");

    }
    public function edit($id)
    {
        $config = $this->data_model->getEdit($id);

        if (!$config) {
            show_error("There is no config with ID " . $id, 400);

            die();
        }
        $data = array(
            'url'     => $this->template->page_url,
            'id'     => $id,
            'config' => $config,
            "this"    => $this
        );
        $output = $this->template->loadPage("admin_edit.tpl", $data);
        $content = $this->administrator->box('Edit Services', $output);
        $this->administrator->view($content, false, "modules/character_tools/js/admin.js");

    }

    public function save($id = false)
    {
        if (!$id || !is_numeric($id)) {
            die();
        }
        $data['type'] = $this->input->post("type");
        $data['amount'] = $this->input->post("amount");
        $data['active'] = $this->input->post("active");
        $this->data_model->save($id, $data);
        $data = [
            'status' => true,
            'icon' => 'success',
            'text' => "Successfully"
        ];
        die(json_encode($data));
    }

}