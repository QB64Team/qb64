void vwatch(uint32 linenumber, uint32 inclinenumber = 0, const char* incfilename = NULL) {
    if (console) {
        std::cout << linenumber << std::endl;
    }
    return;        
}