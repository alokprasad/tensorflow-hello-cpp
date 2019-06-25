#include "tensorflow/core/public/session.h"
#include "tensorflow/core/platform/env.h"
#include <iostream>
#include <string>
const static std::string kModelPath = "../model/test_model.pb";

//DT_STRING is not supported in libtensorflow-core.a slim version , so only DT_INT32 will
//retrain the model with INT32 inputs to generate model and test.
//If you want to build full tensorflow then disable IS_MOBILE_PLATFORM , IS_SLIM_BUILD and enable __ANDROID_FULL_BUILD 
//and make SLIM_ANDROID false , you have retrain the model to generate new graph also.

#define SLIM_ANDROID false

int main()
{
    using namespace tensorflow;
    auto session = NewSession(SessionOptions());
    if (session == nullptr)
    {
        std::cerr << "Tensorflow session create failded.\n";
        return -1;
    }
    else
    {
        std::cout << "Tensorflow session create success.\n";
    }
    Status status;
    // Read in the protobuf graph we exported
    GraphDef graph_def;
    status = ReadBinaryProto(Env::Default(), kModelPath, &graph_def);
    if (!status.ok())
    {
        std::cerr << "Error reading graph definition from " << kModelPath
            << ": " << status.ToString();
        return -1;
    }
    else
    {
        std::cout << "Read graph def success.\n";
    }
    // Add the graph to the session
    status = session->Create(graph_def);
    if (!status.ok())
    {
        std::cerr << "Error creating graph: " << status.ToString();
        return -1;
    }
    else
    {
        std::cout << "Create graph success.\n";
    }
    // Set model input
#if SLIM_BUILD
    Tensor hello(DT_INT32, TensorShape());
    hello.scalar<int>()() = 5;
    Tensor tensorflow(DT_INT32, TensorShape());
    tensorflow.scalar<int>()() = 7;
#else
	Tensor hello(DT_STRING, TensorShape());
    hello.scalar<string>()() = "HELLO ";
    Tensor tensorflow(DT_STRING, TensorShape());
    tensorflow.scalar<string>()() = "WORLD";
#endif
   
    // Apply the loaded model
    std::vector<std::pair<string, tensorflow::Tensor>> inputs =
    {
        { "a", hello },
        { "b", tensorflow },
    }; // input
    std::vector<tensorflow::Tensor> outputs; // output
    status = session->Run(inputs, {"result"}, {}, &outputs);
    if (!status.ok())
    {
        std::cerr << status.ToString() << std::endl;
        return -1;
    }
    else
    {
        std::cout << "Run session successfully" << std::endl;
    }
    // Output the result

#if SLIM_BUILD
    const auto result = outputs[0].scalar<int>()();
#else
    const auto result = outputs[0].scalar<string>()();
#endif
    std::cout << "Result value: " << result << std::endl;
    status = session->Close();
    if (!status.ok())
    {
        std::cerr << "Session closed success";
        return -1;
    }
    return 0;
}
